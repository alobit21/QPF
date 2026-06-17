import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Amenity } from './entities/amenity.entity';

@Injectable()
export class AmenitiesService {
  constructor(
    @InjectRepository(Amenity)
    private amenitiesRepository: Repository<Amenity>,
  ) {}

  create(createDto: any) {
    const amenity = this.amenitiesRepository.create(createDto);
    return this.amenitiesRepository.save(amenity);
  }

  findAll() {
    return this.amenitiesRepository.find();
  }

  async findById(id: string) {
    const amenity = await this.amenitiesRepository.findOne({ where: { id } });
    if (!amenity) throw new NotFoundException('Amenity not found');
    return amenity;
  }
}
