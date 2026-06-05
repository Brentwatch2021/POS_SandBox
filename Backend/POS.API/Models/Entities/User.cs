namespace POS.API.Models.Entities
{
    public class User
    {
        public int UserId { get; set; }

        public int StoreId { get; set; }

        public string Fullname { get; set; } = string.Empty;

        public string Email_Username { get; set; } = string.Empty;

        public string PasswordHash { get; set; } = string.Empty;

        public List<string> Roles { get; set; }  = new List<string>();
    }
}
