namespace POS.API.Models.Entities
{
    public class User
    {
        public int UserId { get; set; }

        public string Email_Username { get; set; } = string.Empty;

        public string PasswordHash { get; set; } = string.Empty;
    }
}
