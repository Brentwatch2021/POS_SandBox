using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace POS.API.Controllers
{
    public class POSController : ControllerBase
    {
        [Authorize(Roles = "Manager, Cashier")]
        [HttpGet("GetStock")]
        public IActionResult GetStock()
        {
            return Ok("This is a protected endpoint for Managers and Cashiers.");
        }
    }
}
