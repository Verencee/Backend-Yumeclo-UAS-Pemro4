# Backend Rental Cosplay

This backend is built using Node.js + Express, Prisma as the ORM, and Cloudinary for image uploads.

Frontend repository:
👉 https://github.com/Verencee/Frontend-Yumeclo-UAS-Pemro3
---

## 🗂 Folder Structure

folders in this backend:

- `/controller` → main logic (costumes, rentals, users)
- `/config` → Cloudinary configuration
- `/prisma` → Prisma schema
- `.env` → environment variables
- `index.js` → main server file

---

## 🚀 How to Run the Backend

1. Clone this repository
2. Navigate into the backend folder
3. Run `npm install`
4. Create `.env` file and fill it with:
- DATABASE_URL="xx"
- CLOUDINARY_CLOUD_NAME=xx
- CLOUDINARY_API_KEY=xx
- CLOUDINARY_API_SECRET=xx
- JWT_SECRET=xx 

5. Start the server using:
- `nodemon`
