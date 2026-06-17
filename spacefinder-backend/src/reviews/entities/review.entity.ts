import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, ManyToOne, JoinColumn } from 'typeorm';
import { User } from '../../users/entities/user.entity';
import { Office } from '../../offices/entities/office.entity';
import { Booking } from '../../bookings/entities/booking.entity';

@Entity()
export class Review {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @ManyToOne(() => User)
  @JoinColumn({ name: 'userId' })
  user: User;

  @Column()
  userId: string;

  @ManyToOne(() => Office)
  @JoinColumn({ name: 'officeId' })
  office: Office;

  @Column()
  officeId: string;

  @ManyToOne(() => Booking)
  @JoinColumn({ name: 'bookingId' })
  booking: Booking;

  @Column()
  bookingId: string;

  @Column('int')
  rating: number; // 1-5

  @Column('text')
  comment: string;

  @CreateDateColumn()
  createdAt: Date;
}
