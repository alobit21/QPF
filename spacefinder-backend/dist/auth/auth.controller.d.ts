import { AuthService } from './auth.service';
export declare class AuthController {
    private authService;
    constructor(authService: AuthService);
    register(registerDto: any): Promise<{
        access_token: string;
        refresh_token: string;
    }>;
    login(loginDto: any): Promise<{
        access_token: string;
        refresh_token: string;
    }>;
    refreshToken(tokenDto: any): Promise<{
        message: string;
    }>;
    forgotPassword(dto: any): Promise<{
        message: string;
    }>;
    resetPassword(dto: any): Promise<{
        message: string;
    }>;
}
