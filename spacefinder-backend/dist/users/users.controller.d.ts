import { UsersService } from './users.service';
export declare class UsersController {
    private readonly usersService;
    constructor(usersService: UsersService);
    getProfile(user: any): Promise<import("./entities/user.entity").User>;
    updateProfile(user: any, updateDto: any): Promise<import("./entities/user.entity").User>;
    changePassword(user: any, passDto: any): Promise<{
        message: string;
    }>;
    removeAccount(user: any): Promise<void>;
}
