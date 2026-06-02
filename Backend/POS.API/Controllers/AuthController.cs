using Microsoft.AspNetCore.Mvc;
using POS.API.Services;
using POS.API.Services.Interfaces;
using System.Threading.Tasks;

namespace POS.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private IAuthService _authService;

        public AuthController(IAuthService authService)
        {
            _authService = authService;
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] Models.DTOs.Requests.LoginRequest request)
        {
            var result = await _authService.LoginAsync(request);
            if (result == null) {
                return Unauthorized(new { Message = "Invalid credentials" });
            }
            return Ok(result);
        }
    }
}
