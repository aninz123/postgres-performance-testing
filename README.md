# PostgreSQL Performance Testing

This repository contains a Docker-based environment for PostgreSQL performance testing and optimization. It includes a PostgreSQL database with configurable resources and an auto-configured pgAdmin interface for easy management and querying.

## Features

- PostgreSQL 13 with adjustable resource limits for performance testing
- Pre-configured pgAdmin 4 for easy database management and query analysis
- Automatic database population script for generating test data
- Docker Compose setup for easy deployment and resource configuration

## Prerequisites

- Docker
- Docker Compose

## Quick Start

1. Clone this repository:
   ```
   git clone https://github.com/aninz123/postgres-performance-testing.git
   cd postgres-performance-testing
   ```

2. Start the environment:
   ```
   docker-compose up -d
   ```

3. Access pgAdmin:
   - Open your browser and go to `http://localhost:8080`

4. The PostgreSQL server "Postgres Performance Test" should be automatically connected and ready for testing.
      - User : testuser
      - Password: testpass

## Configuration

The `docker-compose.yml` file contains the main configuration for both PostgreSQL and pgAdmin. You can adjust the following to test different performance scenarios:

### PostgreSQL

- Resource limits (CPU and memory)
- PostgreSQL parameters (max_connections, shared_buffers, work_mem, etc.)

### pgAdmin

- Default login credentials
- Auto-connected server details

## Database Population

The initial SQL script (`init.sql`) populates the database with sample data. You can modify this script to create your own test data or schema for specific performance testing scenarios.

## Performance Testing

1. Use pgAdmin to run your SQL queries and analyze their performance.
2. Adjust PostgreSQL parameters in `docker-compose.yml` and restart the containers to see how they affect query performance.
3. Use PostgreSQL's EXPLAIN ANALYZE to get detailed query execution plans.
4. Monitor resource usage using Docker's built-in stats command: `docker stats`
5. Experiment with different indexing strategies and analyze their impact on query performance.

## Benchmarking

You can use tools like `pgbench` for standardized PostgreSQL benchmarking. To run `pgbench`:

1. Connect to the PostgreSQL container:
   ```
   docker exec -it postgres_performance_test bash
   ```
2. Run pgbench (example):
   ```
   pgbench -i -s 50 testdb
   pgbench -c 10 -j 2 -t 1000 testdb
   ```

## Cleanup

To stop and remove all containers, networks, and volumes:

```
docker-compose down -v
```

## Security Note

This setup is intended for local development and testing only. It includes saved passwords and reduced security settings that are not appropriate for production environments.

## Contributing

Feel free to open issues or submit pull requests if you have suggestions for improvements, additional testing scenarios, or encounter any problems.
