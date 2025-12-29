module.exports = ({ env }) => ({
  connection: {
    client: 'postgres',
    connection: {
      host: env('DATABASE_HOST', 'localhost'),      // From Terraform output: RDS endpoint
      port: env.int('DATABASE_PORT', 5432),        // Default Postgres port
      database: env('DATABASE_NAME', 'strapi'),    // RDS database name
      user: env('DATABASE_USERNAME', 'strapi'),    // RDS username
      password: env('DATABASE_PASSWORD', 'strapi'),// RDS password
      ssl: {
        rejectUnauthorized: false,                 // Required for AWS RDS public SSL connection
      },
    },
    pool: {
      min: 2,
      max: 10,
    },
    acquireConnectionTimeout: 60000,
  },
});
