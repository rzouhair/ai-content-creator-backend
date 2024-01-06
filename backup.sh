# Get the Docker container ID of the "postgres" container
container_id=$(docker ps -qf "ancestor=postgres")

# Check if the container_id is not empty
if [ -n "$container_id" ]; then
    # Use the container_id in your commands
    docker exec -t "$container_id" pg_dumpall -c -U postgres > "dump_$(date +%d-%m-%Y"_"%H_%M_%S).sql"
else
    echo "No container with the 'postgres' image found."
fi