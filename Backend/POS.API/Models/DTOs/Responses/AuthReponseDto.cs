namespace POS.API.Models.DTOs.Responses
{
    public class AuthResponseDto
    {
        public string Token { get; set; } = string.Empty;

        public string Email_Username { get; set; } = string.Empty;

        public DateTime ExpiresAt { get; set; }

    }
}
