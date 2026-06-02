using POS.API.Models.DTOs.Requests;
using POS.API.Models.DTOs.Responses;
using POS.API.Services.Interfaces;

namespace POS.API.Services
{
    public class AuthService : IAuthService
    {
        private readonly IUserRepository _userRepository;
        private readonly IJWTService _jwt;

        public AuthService(IUserRepository userRepository, IJWTService jwt)
        {
            _userRepository = userRepository;
            _jwt = jwt;
        }

        public async Task<AuthResponseDto?> LoginAsync(LoginRequest request)
        {
            var user = await _userRepository.GetByEmail_UsernameAsync(request.Email_Username);
            if (user == null) 
            {
                return null;
            }
            var valid = false;
            if (user.PasswordHash == string.Empty)
            {
                await _userRepository.SetPasswordAsync(request.Email_Username, request.Password);
                return new AuthResponseDto
                {
                    Token = _jwt.GenerateToken(user),
                    Email_Username = user.Email_Username
                };
            }
            else
            {
                valid = BCrypt.Net.BCrypt.Verify(request.Password, user.PasswordHash);
            }
            
            if(!valid)
                return null;

            return new AuthResponseDto
            {
                Token = _jwt.GenerateToken(user),
                Email_Username = user.Email_Username
            };

        }
    }
}
