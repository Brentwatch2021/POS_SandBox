namespace POS.API.Models.DTOs.Requests
{
    public class LoginRequest
    {
        public string Email_Username { get; set; } = "";
        public string Password { get; set; } = "";
    }
}
