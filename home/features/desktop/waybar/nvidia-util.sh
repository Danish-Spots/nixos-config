#!/usr/bin/env bash


nvidia-smi \
  --query-gpu=power.draw,temperature.gpu,utilization.gpu,driver_version,memory.total,memory.reserved,memory.used,memory.free \
  --format=csv,noheader,nounits | while IFS= read -r line; do

  IFS=',' read -r power temp util driver total reserved used free <<EOF
$(echo "$line" | sed 's/, */,/g')
EOF

  power=$(echo "$power" | xargs)
  temp=$(echo "$temp" | xargs)
  util=$(echo "$util" | xargs)
  driver=$(echo "$driver" | xargs)
  total=$(echo "$total" | xargs)
  reserved=$(echo "$reserved" | xargs)
  used=$(echo "$used" | xargs)
  free=$(echo "$free" | xargs)

  # Output JSON
  printf '{'
  printf '"text": "󱄄 %s Watts %s°C %s%%", ' "$power" "$temp" "$util"
  printf '"tooltip": "Driver driver: %s\\n\\nMemory: %s MiB / total MiB\\nFree: %s MiB\\nReserved: %s MiB", ' "$driver" "$used" "$free" "$reserved"
  printf '"class": "custom-nvidia", '
  printf '"alt": "gpu"'
  printf '}\n'
done