import { ReviewsService } from './reviews.service';
export declare class ReviewsController {
    private readonly reviewsService;
    constructor(reviewsService: ReviewsService);
    create(user: any, createDto: any): Promise<import("./entities/review.entity").Review[]>;
    findByOffice(id: string): Promise<import("./entities/review.entity").Review[]>;
    findMyReviews(user: any): Promise<import("./entities/review.entity").Review[]>;
    remove(id: string, user: any): Promise<import("./entities/review.entity").Review>;
}
