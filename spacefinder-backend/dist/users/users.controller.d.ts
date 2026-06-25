import { UsersService } from './users.service';
import { UserRole } from './entities/user.entity';
export declare class UsersController {
    private readonly usersService;
    constructor(usersService: UsersService);
    findAll(): Promise<import("./entities/user.entity").User[]>;
    updateRole(id: string, role: UserRole): Promise<import("./entities/user.entity").User>;
    getProfile(user: any): Promise<import("./entities/user.entity").User>;
    updateProfile(user: any, updateDto: any): Promise<import("./entities/user.entity").User>;
    changePassword(user: any, passDto: any): Promise<{
        message: string;
    }>;
    removeAccount(user: any): Promise<void>;
}
