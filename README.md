# Backend Rental Cosplay

Backend ini dibuat pakai Node.js + Express, Prisma sebagai ORM, dan Cloudinary untuk cloud upload gambar.

Clone frontend-nya:  
👉 https://github.com/USERNAME/LINK-FRONTEND-MU

---

## 🗂 Struktur Folder

folder penting di backend ini:

- `/controller` → tempat logic utama (costumes, rentals, users)
- `/config` → konfigurasi Cloudinary
- `/prisma` → schema Prisma
- `.env` → file environment (tidak ikut GitHub)
- `index.js` → file utama untuk jalanin server

---

## 🚀 Cara Jalanin Backend

1. Clone repo ini:
2. Masuk ke folder backend
3. Jalankan npm i
4. Buat file .env
- DATABASE_URL="xx"
- CLOUDINARY_CLOUD_NAME=xx
- CLOUDINARY_API_KEY=xx
- CLOUDINARY_API_SECRET=xx
- JWT_SECRET=xx 

5. Jalankan server di terminal ketik nodemon
