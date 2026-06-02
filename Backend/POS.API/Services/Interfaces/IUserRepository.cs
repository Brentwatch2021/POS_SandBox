using POS.API.Models.Entities;

namespace POS.API.Services.Interfaces
{
    public interface IUserRepository
    {
        Task<User?> GetByEmail_UsernameAsync(string email_UserName);
        //Task CreateAsync(User user);
        Task SetPasswordAsync(string email_UserName, string requestedPassword);
    }
}
