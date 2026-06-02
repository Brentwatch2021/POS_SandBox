using Microsoft.AspNetCore.DataProtection.KeyManagement;
using Microsoft.AspNetCore.Identity;
using Microsoft.Data.SqlClient;
using POS.API.Data;
using POS.API.Models.Entities;
using POS.API.Services.Interfaces;
using System;
using System.Data;

namespace POS.API.Repositories
{
    public class UserRepository : IUserRepository
    {
        private readonly DbConnectionFactory _factory;

        public UserRepository(DbConnectionFactory factory)
        {
            _factory = factory;
        }

        public async Task<User?> GetByEmail_UsernameAsync(string email_UserName)
        {
            using var conn = _factory.CreateConnection();
            await conn.OpenAsync();

            using var cmd = new SqlCommand(@"SELECT TOP 1 UserId, StoreID, FullName, PasswordHash
                                               FROM [dbo].[pos_User]
                                              WHERE Username = @Username", conn);

            cmd.Parameters.AddWithValue("@Username", email_UserName);

            using var reader = await cmd.ExecuteReaderAsync();

            if(!await reader.ReadAsync())
                return null;

            return new User
            {
                Email_Username = email_UserName,
                UserId = reader.GetInt32(reader.GetOrdinal("UserId"))!,
                StoreId = reader.GetInt32(reader.GetOrdinal("StoreId"))!,
                Fullname = reader["FullName"].ToString()!,
                PasswordHash = reader["PasswordHash"]?.ToString()
            };
        }

        public async Task SetPasswordAsync(string email_UserName, string requestedPassword)
        {
            var passwordHash = BCrypt.Net.BCrypt.HashPassword(requestedPassword);

            using var conn = _factory.CreateConnection();
            await conn.OpenAsync();

            using var cmd = new SqlCommand(@"UPDATE [dbo].[pos_User]
                                                SET PasswordHash = @PasswordHash
                                              WHERE Username = @Username", conn);

            cmd.Parameters.AddWithValue("@Username", email_UserName);
            cmd.Parameters.AddWithValue("@PasswordHash", passwordHash);

            await cmd.ExecuteNonQueryAsync();
        }
        
    }
}
