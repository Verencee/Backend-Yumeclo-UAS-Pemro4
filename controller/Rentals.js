import express from "express";
import { PrismaClient } from "@prisma/client";
import { authenticateToken } from "./Users.js";

const prisma = new PrismaClient();

//Validasi Kamu siapa
const authorizeAdmin = (req, res, next) => {
  if (req.user.role !== "admin") {
    return res.status(403).json({ message: "Akses ditolak: Kamu bukan admin" });
  }
  next();
};

export const createRentalController = () => {
  const router = express.Router();

  // Cosplayer Ngerent cuy
  router.post("/create-rental", authenticateToken, async (req, res) => {
    try {
      const userId = req.user.id;
      const data = req.body;
      const costume_id = parseInt(data.costume_id);
      console.log(costume_id);
      console.log(userId);

      const costume = await prisma.costumes.findUnique({
        where: {
          costume_id: costume_id,
        },
      });
      if (!costume || costume.stock < 1) {
        return res
          .status(400)
          .send("Kostum tidak tersedia atau stok habis");
      }

      const totalPrice = costume.price;

      const newRental = await prisma.rentals.create({
        data: {
          user_id: userId,
          costume_id: costume_id,
          rental_start: null,
          rental_end: null,
          total_price: totalPrice,
          status: "pending",
        },
      });

      await prisma.costumes.update({
        where: {
          costume_id: costume_id,
        },
        data: {
          stock: {
            decrement: 1,
          },
        },
      });

      res
        .status(201)
        .json({ message: "Rental berhasil dibuat", rental: newRental });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Terjadi kesalahan server" });
    }
  });

  // Ambil rentalan si cosplayer (all)
  router.get("/rentals-list", authenticateToken, async (req, res) => {
    try {
      const userId = req.user.id;
      // const userId = parseInt(req.params.id);


      const rentals = await prisma.rentals.findMany({
        where: {
          user_id: userId
        },
        include: {
          costumes: true,
        },
        orderBy: {
          created_at: "desc",
        },
      });

      res.json(rentals);
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Gagal mengambil data rental" });
    }
  });

  // cos (pending)
  router.get('/rentals/pending', authenticateToken, async (req, res) => {
    try {
      const userId = req.user.id;
      console.log(userId)

      const pendingRentals = await prisma.rentals.findMany({
        where: {
          user_id: userId,
          status: 'pending'
        },
        include: {
          users: {
            select: {
              full_name: true,
              address: true
            }
          },
          costumes: {
            include: {
              costumeimages: {
                where: {
                  is_main: true
                }
              }
            }
          }
        }
      });
      res.status(200).json({ data: pendingRentals });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Gagal mengambil data rental" });
    }
  });

  // cos (ongoing)
  router.get('/rentals/ongoing', authenticateToken, async (req, res) => {
    try {
      const userId = req.user.id;
      console.log(userId)

      const ongoingRentals = await prisma.rentals.findMany({
        where: {
          user_id: userId,
          status: 'ongoing'
        },
        include: {
          users: {
            select: {
              full_name: true,
              address: true
            }
          },
          costumes: {
            include: {
              costumeimages: {
                where: {
                  is_main: true
                }
              }
            }
          }
        }
      });
      res.status(200).json({ data: ongoingRentals });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Gagal mengambil data rental" });
    }
  });

  // cos konfirmasi active set rental_start rental_end 4 hari)
  router.put("/start/:id", authenticateToken, async (req, res) => {
    try {
      const rentalId = parseInt(req.params.id);
      const userId = req.user.id;
      console.log(rentalId);
      console.log(userId);

      const rental = await prisma.rentals.findUnique({
        where: {
          rental_id: rentalId,
        },
        include: {
          costumes: true,
        },
      });
      if (!rental || rental.user_id !== userId) {
        return res.status(404).send("Rental tidak ditemukan");
      }
      if (rental.status !== "ongoing") {
        return res
          .status(400)
          .send("Rental tidak dalam status ongoing");
      }

      const startDate = new Date();
      const endDate = new Date();
      endDate.setDate(startDate.getDate() + 4);

      const updatedRental = await prisma.rentals.update({
        where: {
          rental_id: rentalId,
        },
        data: {
          status: "active",
          rental_start: startDate,
          rental_end: endDate,
        },
      });

      console.log(updatedRental);

      return res.status(200).send(`Rental Kostum ${rental.costumes.name}`);
    } catch (error) {
      console.error(error);
      res.status(500).send("Gagal memulai rental, server bermasalah");
    }
  });

  // cos (active)
  router.get('/rentals/active', authenticateToken, async (req, res) => {
    try {
      const userId = req.user.id;
      console.log(userId)

      const activeRentals = await prisma.rentals.findMany({
        where: {
          user_id: userId,
          status: 'active'
        },
        include: {
          users: {
            select: {
              full_name: true,
              address: true
            }
          },
          costumes: {
            include: {
              costumeimages: {
                where: {
                  is_main: true
                }
              }
            }
          }
        }
      });
      res.status(200).json({ data: activeRentals });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Gagal mengambil data rental" });
    }
  });

  // cos konfirmasi (returning)
  router.put("/return/:id", authenticateToken, async (req, res) => {
    try {
      const rentalId = parseInt(req.params.id);
      const userId = req.user.id;
      console.log(rentalId);
      console.log(userId);

      const rental = await prisma.rentals.findUnique({
        where: {
          rental_id: rentalId,
        },
        include: {
          costumes: true,
        },
      });
      if (!rental || rental.user_id !== userId) {
        return res.status(404).send("Rental tidak ditemukan");
      }
      if (rental.status !== "active") {
        return res
          .status(400)
          .send("Rental tidak dalam status active");
      }

      const returningRental = await prisma.rentals.update({
        where: {
          rental_id: rentalId,
        },
        data: {
          status: "returning",
        },
      });

      console.log(returningRental);

      return res.status(200).send(`Mengembalikan kostum ${rental.costumes.name}`);
    } catch (error) {
      console.error(error);
      res.status(500).send("Gagal mengembalikan rental, server bermasalah");
    }
  });

  // cos (completed)
  router.get('/rentals/completed', authenticateToken, async (req, res) => {
    try {
      const userId = req.user.id;
      console.log(userId)

      const completedRentals = await prisma.rentals.findMany({
        where: {
          user_id: userId,
          status: 'completed'
        },
        include: {
          users: {
            select: {
              full_name: true,
              address: true
            }
          },
          costumes: {
            include: {
              costumeimages: {
                where: {
                  is_main: true
                }
              }
            }
          }
        }
      });
      res.status(200).json({ data: completedRentals });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Gagal mengambil data rental" });
    }
  });

  // tampil semua rentalan menu kang rental (pending)
  router.get("/rentals-all-pending-list", authenticateToken, authorizeAdmin, async (req, res) => {
    try {
      const status_pending = "pending";
      const all_pending_rentals = await prisma.rentals.findMany({
        where: {
          status: status_pending,
        },
        include: {
          users: {
            select: {
              full_name: true,
              address: true
            }
          },
          costumes: {
            include: {
              costumeimages: {
                where: {
                  is_main: true
                }
              }
            }
          }
        },
        orderBy: {
          created_at: "desc",
        },
      });

      res.status(200).json({ data: all_pending_rentals });
      // console.log(all_pending_rentals);
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Gagal mengambil data rental" });
    }
  });

  // tampil semua rentalan menu kang rental (active)
  router.get("/rentals-all-active-list", authenticateToken, authorizeAdmin, async (req, res) => {
    try {
      const status_active = "active";
      const all_active_rentals = await prisma.rentals.findMany({
        where: {
          status: status_active,
        },
        include: {
          users: {
            select: {
              full_name: true,
              address: true
            }
          },
          costumes: {
            include: {
              costumeimages: {
                where: {
                  is_main: true
                }
              }
            }
          }
        },
        orderBy: {
          created_at: "desc",
        },
      });

      res.status(200).json({ data: all_active_rentals });
      // console.log(all_active_rentals);
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Gagal mengambil data rental" });
    }
  });

  // tampil semua rentalan menu kang rental (returning)
  router.get("/rentals-all-returning-list", authenticateToken, authorizeAdmin, async (req, res) => {
    try {
      const status_returning = "returning";
      const all_returning_rentals = await prisma.rentals.findMany({
        where: {
          status: status_returning,
        },
        include: {
          users: {
            select: {
              full_name: true,
              address: true
            }
          },
          costumes: {
            include: {
              costumeimages: {
                where: {
                  is_main: true
                }
              }
            }
          }
        },
        orderBy: {
          created_at: "desc",
        },
      });

      res.status(200).json({ data: all_returning_rentals });
      // console.log(all_returning_rentals);
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Gagal mengambil data rental" });
    }
  });

  // Kang rent konfirmasi ongoing
  router.put("/confirm/:id", authenticateToken, authorizeAdmin, async (req, res) => {
    try {
      const rentalId = parseInt(req.params.id);

      const rental = await prisma.rentals.findUnique({
        where: {
          rental_id: rentalId,
        },
      });

      if (!rental) {
        return res.status(404).json({ message: "Rental tidak ditemukan" });
      }
      if (rental.status !== "pending") {
        return res
          .status(400)
          .json({ message: "Rental tidak dalam status pending" });
      }

      await prisma.rentals.update({
        where: {
          rental_id: rentalId,
        },
        data: {
          status: "ongoing",
        },
      });

      res.json({ message: "Berhasil konfirmasi rental kostum" });

    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Gagal konfirmasi rental" });
    }

  });

  //Kang rental returning -> complete rental + stok nambah
  router.put("/complete/:id", authenticateToken, authorizeAdmin, async (req, res) => {
    try {
      const rentalId = parseInt(req.params.id);

      const rental = await prisma.rentals.findUnique({
        where: {
          rental_id: rentalId,
        },
      });

      if (!rental) {
        return res.status(404).json({ message: "Rental tidak ditemukan" });
      }
      if (rental.status !== "returning") {
        return res
          .status(400)
          .json({ message: "Rental tidak dalam status returning" });
      }

      await prisma.rentals.update({
        where: {
          rental_id: rentalId,
        },
        data: {
          status: "completed",
        },
      });

      await prisma.costumes.update({
        where: {
          costume_id: rental.costume_id,
        },
        data: {
          stock: {
            increment: 1
          },
        },
      });

      res.json({ message: "Rental selesai dan stok kostum dikembalikan" });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Gagal menyelesaikan rental" });
    }
  }
  );

  return router;
};
