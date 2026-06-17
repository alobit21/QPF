import { Entity, PrimaryGeneratedColumn, Column, ManyToMany } from 'typeorm';
import { Office } from '../../offices/entities/office.entity';

@Entity()
export class Amenity {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  name: string;

  @Column()
  icon: string;

  @ManyToMany(() => Office, office => office.amenities)
  offices: Office[];
}
