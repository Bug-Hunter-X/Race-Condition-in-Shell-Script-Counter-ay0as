#!/bin/bash

# This script demonstrates a race condition in shell scripting.
# It uses two processes to increment a counter in a file.
# However, due to the lack of proper locking mechanisms, the final
# counter value may be less than expected.

counter_file="counter.txt"

# Initialize the counter file
echo 0 > "$counter_file"

# Function to increment the counter
increment_counter() {
  while true; do
    value=$(cat "$counter_file")
    new_value=$((value + 1))
    echo "$new_value" > "$counter_file"
    sleep 0.1
  done
}

# Run two processes to increment the counter
increment_counter &
increment_counter &

# Wait for a few seconds
sleep 5

# Kill the processes
kill %1 %2

# Display the final counter value
final_value=$(cat "$counter_file")
echo "Final counter value: $final_value"