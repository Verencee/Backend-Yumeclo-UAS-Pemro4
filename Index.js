import express from "express";
import { createCostumeController } from "./controller/Costumes.js";
import { createUserController } from "./controller/Users.js";
import { createRentalController } from "./controller/Rentals.js";
import { PrismaClient } from "@prisma/client";
import cors from "cors";

const prisma = new PrismaClient({});

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Route utama
app.get("/", async (req, res) => {
  // test html
  try {
    const costumes = await prisma.costumes.findMany({
      include: {
        costumeimages: {
          select: {
            image_url: true,
          },
        },
      },
    });
    const simplified = costumes.map((c) => ({
      name: c.name,
      images: c.costumeimages.map((img) => img.image_url),
    }));
    const html = `
      <html>
        <head><title>Daftar Kostum</title></head>
        <body>
          <h1>Daftar Kostum</h1>
          ${simplified
        .map(
          (c) => `
            <div>
              <h2>${c.name}</h2>
              ${c.images
              .map((url) => `<img src="${url}" width="150" height="150" />`)
              .join("")}
            </div>
          `
        )
        .join("")}
        </body>
      </html>
    `;
    res.send(html);
  } catch (error) {
    console.error(error);
    res.status(500).send("Terjadi kesalahan server");
  }
  // test html
});

// Route
app.use("/costume", createCostumeController());
app.use("/user", createUserController());
app.use("/rental", createRentalController());

app.listen(PORT, () => {
  console.log(`Server berjalan di http://localhost:${PORT}`);
});
