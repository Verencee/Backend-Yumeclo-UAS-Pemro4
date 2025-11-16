import express from "express";
import bcrypt from "bcrypt";
import { PrismaClient } from "@prisma/client";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";

dotenv.config();

const prisma = new PrismaClient({});

// AuthenticateToken
const authenticateToken = (req, res, next) => {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];

  if (!token) return res.status(401).json({ message: "Token tidak ditemukan" });

  jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
    if (err) return res.status(403).json({ message: "Token tidak valid" });
    req.user = user;
    next();
  });
};

export { authenticateToken };

export const createUserController = () => {
  const router = express.Router();

  // Register
  router.post("/register", async (req, res) => {
    try {
      const data = req.body;
      const password_raw = data.password;

      // Cek Username
      const isUsernameExits = await prisma.users.findUnique({
        where: {
          username: data.username,
        },
      });

      if (isUsernameExits) {
        return res.status(500).send("Username Telah Digunakan");
      }

      // Encrypt Password
      const pw_encrypted = await bcrypt.hash(password_raw, 15);

      console.log(data);
      console.log(pw_encrypted);

      // Simpan Data
      await prisma.users.create({
        data: {
          username: data.username,
          nik_ktp: data.nik_ktp,
          email: data.email,
          password: pw_encrypted,
        },
      });

      res.status(201).json({ message: "Berhasil Registrasi" });
    } catch (error) {
      res.status(500).send("Terjadi kesalahan server");
    }
  });

  // Login
  router.post("/login", async (req, res) => {
    try {
      const data = req.body;
      const password_login = data.password;

      const user = await prisma.users.findUnique({
        where: {
          username: data.username,
        },
      });

      if (!user) {
        return res.status(400).send("Username tidak terdaftar");
      }

      const isPasswordMatch = await bcrypt.compare(
        password_login,
        user.password
      );
      if (!isPasswordMatch) {
        return res.status(400).send("Periksa passwordmu");
      }

      const userPayload = {
        id: user.user_id,
        username: user.username,
        role: user.role,
      };

      const token = jwt.sign(userPayload, process.env.JWT_SECRET, {
        expiresIn: "4h",
      });

      console.log("Token :", token);

      res.status(200).json({
        fullname: user.full_name,
        username: user.username,
        email: user.email,
        phonenumber: user.phone_number,
        nik: user.nik_ktp,
        address: user.address,
        role: user.role,
        token,
      });
    } catch (error) {
      console.log(error);
      res.status(500).send("Terjadi kesalahan server");
    }
  });

  // Get Profile
  router.get("/profile", authenticateToken, async (req, res) => {
    try {
      const userId = req.user.id;

      const getuser = await prisma.users.findUnique({
        where: {
          user_id: userId,
        },
        select: {
          full_name: true,
          username: true,
          email: true,
          phone_number: true,
          address: true,
          nik_ktp: true,
          role: true,
        },
      });

      if (!getuser)
        return res.status(404).json({ message: "User tidak ditemukan" });

      res.json(getuser);
    } catch (error) {
      console.log(error);
      res.status(500).json({ message: "Terjadi kesalahan server" });
    }
  });

  // Put Profile
  router.put("/profile", authenticateToken, async (req, res) => {
    try {
      const data = req.body;
      const userId = req.user.id;
      console.log(userId);

      const updateData = {
        full_name: data.full_name,
        phone_number: data.phone_number,
        address: data.address,
      };

      const updateUser = await prisma.users.update({
        where: {
          user_id: userId,
        },
        data: updateData,
      });

      if (!updateUser)
        return res.status(400).send("Gagal Update Data Profile");

      res.status(200).send("Berhasil Update Profile Data");
    } catch (error) {
      console.log(error);
      res.status(500).send("Terjadi kesalahan server");
    }
  });

  // Delete Profile
  router.delete("/delete", authenticateToken, async (req, res) => {
    try {
      const userId = req.user.id;

      const deleteUser = await prisma.users.delete({
        where: {
          user_id: userId,
        },
      });

      if (!deleteUser)
        return res.status(404).json({ message: "User tidak ditemukan" });

      res.status(200).json({ message: "Berhasil Delete Akun" });
    } catch (error) {
      console.log(error);
      res.status(500).json({ message: "Terjadi kesalahan server" });
    }
  });

  return router;
};
