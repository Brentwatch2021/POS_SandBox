using POS.API.Models.DTOs.Requests;
using POS.API.Models.DTOs.Responses;

namespace POS.API.Services.Interfaces
{
    public interface IAuthService
    {
        Task<AuthResponseDto?> LoginAsync(LoginRequest request);

        //Task<AuthReponseDto?> LoginAsync(LoginRequest request);
    }
}
