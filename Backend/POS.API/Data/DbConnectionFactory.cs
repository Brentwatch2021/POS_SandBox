using Microsoft.Data.SqlClient;

namespace POS.API.Data
{
    public class DbConnectionFactory
    {
        private readonly string _configurationString;

        public DbConnectionFactory(IConfiguration configuration)
        {
            _configurationString = configuration.GetConnectionString("Default")!; 
        }

        public SqlConnection CreateConnection()
        => new SqlConnection(_configurationString);

    }
}
