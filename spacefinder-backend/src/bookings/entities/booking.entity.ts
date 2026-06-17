import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn, ManyToOne, JoinColumn, Index } from 'typeorm';
import { User } from '../../users/entities/user.entity';
import { Office } from '../../offices/entities/office.entity';
import { Slot } from '../../slots/entities/slot.entity';

export enum BookingStatus {
  PENDING = 'pending',
  ACCEPTED = 'accepted',
  REJECTED = 'rejected',
  COMPLETED = 'completed',
}

@Entity()
export class Booking {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @ManyToOne(() => User, user => user.bookings)
  @JoinColumn({ name: 'userId' })
  user: User;

  @Index()
  @Column()
  userId: string;

  @ManyToOne(() => Slot, slot => slot.bookings)
  @JoinColumn({ name: 'slotId' })
  slot: Slot;

  @Column()
  slotId: string;

  @ManyToOne(() => Office, office => office.bookings)
  @JoinColumn({ name: 'officeId' })
  office: Office;

  @Index()
  @Column()
  officeId: string;

  @Index()
  @Column({ type: 'enum', enum: BookingStatus, default: BookingStatus.PENDING })
  status: BookingStatus;

  @Column('decimal', { precision: 10, scale: 2 })
  totalPrice: number;

  @Column('int')
  duration: number; // in hours

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}
