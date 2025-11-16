import express from "express";
import { upload } from "../config/Cloudinary.js";
import { cloudinary } from "../config/Cloudinary.js";
import { PrismaClient } from "@prisma/client";
import { authenticateToken } from "./Users.js";

const prisma = new PrismaClient();

//Validasi cuy
const authorizeAdmin = (req, res, next) => {
  if (req.user.role !== "admin") {
    return res.status(403).json({ message: "Akses ditolak: Kamu bukan admin" });
  }
  next();
};

export const createCostumeController = () => {
  const router = express.Router();

  // Upload gambar simpan data kostum
  router.post("/upload", authenticateToken, authorizeAdmin, upload.array("image", 4), async (req, res) => {
    const data = req.body;
    const name = data.name;
    const description = data.description;
    const price = data.price;
    const stock = data.stock;
    const size = data.size;
    const gender = data.gender;
    const category_id = data.category_id;
    const files = req.files;

    if (!files || files.length < 4) {
      return res.status(400).json({ message: "Harus upload minimal 4 gambar" });
    }

    if (!files || files.length === 0) {
      return res.status(400).json({ message: "Gambar tidak ditemukan" });
    }

    try {
      const newCostume = await prisma.costumes.create({
        data: {
          name: name,
          description: description,
          price: parseFloat(price),
          stock: parseInt(stock),
          size: size,
          gender: gender,
          category_id: parseInt(category_id),
        },
      });

      const imagesData = files.map((file, index) => ({
        costume_id: newCostume.costume_id,
        image_url: file.path,
        is_main: index === 0,
        public_id: file.filename,
      }));
      console.log(imagesData);

      await prisma.costumeimages.createMany({
        data: imagesData,
        skipDuplicates: true,
      });

      res.status(201).json({
        message: "Kostum dan gambar berhasil disimpan",
        costume: newCostume,
      });
    } catch (error) {
      console.error("Gagal simpan ke database:", error);
      res.status(500).json({ error: "Gagal menyimpan kostum atau gambar" });
    }
  });

  // Delete gambar delete data kostum
  router.delete("/delete/:id", authenticateToken, authorizeAdmin, async (req, res) => {
    const costumeId = parseInt(req.params.id);

    try {
      const images = await prisma.costumeimages.findMany({
        where: { costume_id: costumeId },
      });

      for (const img of images) {
        if (img.public_id) {
          await cloudinary.uploader.destroy(img.public_id);
        }
      }

      await prisma.costumeimages.deleteMany({
        where: { costume_id: costumeId },
      });

      await prisma.costumes.delete({
        where: { costume_id: costumeId },
      });

      res.sendStatus(204);
    } catch (error) {
      console.error("Gagal menghapus kostum:", error);
      res.status(500).json({ error: "Gagal menghapus kostum atau gambar." });
    }
  });

  // Kategori
  router.get("/category", async (req, res) => {
    try {
      const kategori = await prisma.categories.findMany();
      res.status(200).json(kategori);
    } catch (error) {
      console.error("Gagal ambil kategori kostum:", error);
      res.status(500).json({ message: "Terjadi kesalahan server" });
    }
  });

  // terbaru
  router.get("/", async (req, res) => {
    try {
      const costumes = await prisma.costumes.findMany({
        orderBy: {
          created_at: "desc",
        },
        include: {
          costumeimages: {
            where: { is_main: true },
            select: { image_url: true },
            take: 1,
          },
        },
      });

      const data_costume_card = costumes.map((c) => ({
        id: c.costume_id,
        name: c.name,
        price: Number(c.price),
        gender: c.gender,
        size: c.size,
        stock: c.stock,
        image: c.costumeimages[0]?.image_url || null,
      }));

      res.status(200).json(data_costume_card);
    } catch (error) {
      console.error("Gagal mengambil data kostum:", error);
      res.status(500).json({ message: "Terjadi kesalahan server" });
    }

  });

  // Route Ambil semua
  // router.get("/all", async (req, res) => {
  //   try {
  //     const costumes = await prisma.costumes.findMany({
  //       include: {
  //         costumeimages: {
  //           where: { is_main: true },
  //           select: { image_url: true },
  //           take: 1,
  //         },
  //       },
  //     });

  //     const data_costume_card = costumes.map((c) => ({
  //       id: c.costume_id,
  //       name: c.name,
  //       price: Number(c.price),
  //       gender: c.gender,
  //       size: c.size,
  //       stock: c.stock,
  //       image: c.costumeimages[0]?.image_url || null,
  //     }));

  //     res.status(200).json(data_costume_card);
  //   } catch (error) {
  //     console.error("Gagal mengambil data kostum:", error);
  //     res.status(500).json({ message: "Terjadi kesalahan server" });
  //   }

  // });

  // Detail costume
  router.get("/detail/:id", async (req, res) => {
    const costumeId = parseInt(req.params.id);

    try {
      const costume = await prisma.costumes.findUnique({
        where: { costume_id: costumeId },
        select: {
          name: true,
          description: true,
          price: true,
          size: true,
          gender: true,
          stock: true,
          costumeimages: {
            select: {
              image_url: true,
              is_main: true,
            },
          },
        },
      });

      if (!costume) return res.status(404).send("Costume tidak ditemukan");

      const gambar_utama = costume.costumeimages.find((img) => img.is_main)?.image_url || "";
      const gambar = costume.costumeimages.map((img) => img.image_url);

      res.json({
        name: costume.name,
        description: costume.description,
        price: costume.price,
        size: costume.size,
        gender: costume.gender,
        stock: costume.stock,
        gambar_utama,
        gambar,
      });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Terjadi kesalahan server" });
    }
  });

  //Update data costume rental
  router.put("/update/:id", authenticateToken, authorizeAdmin, async (req, res) => {
    try {
      const costumeId = parseInt(req.params.id);
      const data = req.body;

      const updateCostume = await prisma.costumes.update({
        where: {
          costume_id: costumeId,
        },
        data: {
          name: data.name,
          description: data.description,
          price: parseFloat(data.price),
          stock: parseInt(data.stock),
          size: data.size,
          gender: data.gender,
          category_id: parseFloat(data.category_id),
        },
      });

      if (!updateCostume) {
        return res
          .status(422)
          .json({ message: "Gagal Mengupdate Data Costume" });
      }

      res.status(200).json({ message: "Berhasil Mengupdate Data Costume" });
    } catch (error) {
      console.error("Gagal Update kostum:", error);
      res.status(500).json({ error: "Server Error bro" });
    }
  });

  return router;
};
