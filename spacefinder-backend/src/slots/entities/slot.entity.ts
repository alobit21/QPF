import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn, ManyToOne, JoinColumn, OneToMany } from 'typeorm';
import { Office } from '../../offices/entities/office.entity';
import { Booking } from '../../bookings/entities/booking.entity';

@Entity()
export class Slot {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @ManyToOne(() => Office, office => office.slots, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'officeId' })
  office: Office;

  @Column()
  officeId: string;

  @Column('date')
  date: string;

  @Column('time')
  startTime: string;

  @Column('time')
  endTime: string;

  @Column()
  roomNumber: string;

  @Column({ default: true })
  isAvailable: boolean;

  @OneToMany(() => Booking, booking => booking.slot)
  bookings: Booking[];

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}
