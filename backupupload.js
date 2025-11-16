import express from "express";
import { upload } from "./Cloudinary.js";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export const createUploadController = () => {
  const router = express.Router();

  // Route untuk upload + simpan data kostum
  router.post("/upload", upload.single("image"), async (req, res) => {
    const data = req.body;
    const imageUrl = req.file?.path;

    if (!imageUrl) {
      return res.status(400).json({ message: "File gambar tidak ditemukan" });
    }

    try {
      await prisma.costumes.create({
        data: {
          name: data.name,
          description: data.description,
          image_url: imageUrl,
          price: parseFloat(data.price),
          stock: parseInt(data.stock),
          category_id: parseInt(data.category_id),
        },
      });

      res.status(201).json({ message: "Kostum berhasil disimpan" });
    } catch (err) {
      console.error("Gagal simpan ke database:", err);
      res.status(500).json({ error: "Gagal menyimpan kostum" });
    }
  });

  return router;
};
