using POS.API.Models.Entities;

namespace POS.API.Services.Interfaces
{
    public interface IJWTService
    {
        string GenerateToken(User user);
    }
}
