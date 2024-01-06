# Get the Docker container ID of the "postgres" container
# Replace 'directory_path' with the actual path to the directory where you want to search.
directory_path="."

# Use the 'find' command to search for files matching the pattern
first_matching_file=$(find "$directory_path" -type f -name "dump_*.sql" | sort | head -n 1)
container_id=$(docker ps -qf "ancestor=postgres")

# Check if the container_id is not empty
if [ -n "$container_id" ]; then
  # Check if no argument is passed
  if [ -z "$1" ]; then
    echo "No argument is passed getting the first dump file."
    # Check if a matching file was found
    if [ -n "$first_matching_file" ]; then
      echo "The first matching file is: $first_matching_file"
      cat "$first_matching_file" | docker exec -i "$container_id" psql -U postgres
    else
        echo "No matching files found in $directory_path."
    fi
  else
    echo "Argument 1 is: $1"
    cat "$1" | docker exec -i "$container_id" psql -U postgres
  fi
else
  echo "No container with the 'postgres' image found."
  return
fi
