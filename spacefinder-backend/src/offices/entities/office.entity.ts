import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn, DeleteDateColumn, Index, ManyToOne, JoinColumn, ManyToMany, JoinTable, OneToMany } from 'typeorm';
import { User } from '../../users/entities/user.entity';
import { Amenity } from '../../amenities/entities/amenity.entity';
import { Slot } from '../../slots/entities/slot.entity';
import { Booking } from '../../bookings/entities/booking.entity';

@Entity()
export class Office {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  name: string;

  @Column('text')
  description: string;

  @Column()
  address: string;

  @Index()
  @Column()
  city: string;

  @Column('float', { nullable: true })
  latitude: number;

  @Column('float', { nullable: true })
  longitude: number;

  @Column('decimal', { precision: 10, scale: 2 })
  pricePerHour: number;

  @Column('int')
  size: number;

  @Column('int')
  availableRooms: number;

  @Column('simple-array', { nullable: true })
  images: string[];

  @Column({ default: true })
  isActive: boolean;

  @ManyToOne(() => User, user => user.offices)
  @JoinColumn({ name: 'ownerId' })
  owner: User;

  @Column()
  ownerId: string;

  @ManyToMany(() => Amenity, amenity => amenity.offices)
  @JoinTable({ name: 'office_amenities' })
  amenities: Amenity[];

  @OneToMany(() => Slot, slot => slot.office)
  slots: Slot[];

  @OneToMany(() => Booking, booking => booking.office)
  bookings: Booking[];

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @DeleteDateColumn()
  deletedAt: Date;
}
