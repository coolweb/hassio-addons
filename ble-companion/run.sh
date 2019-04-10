#!/bin/bash
set -e

CONFIG_PATH=/data/options.json

INTERVAL=$(jq --raw-output ".interval" $CONFIG_PATH)
GRACE_PERIOD=$(jq --raw-output ".grace_period" $CONFIG_PATH)
HOME_ASSISTANT_PORT=$(jq --raw-output ".home_assistant_port" $CONFIG_PATH)
HOME_ASSISTANT_PASSWORD=$(jq --raw-output ".home_assistant_password" $CONFIG_PATH)
HOME_ASSISTANT_DEVICES=$(jq --raw-output '.home_assistant_devices | join("%%CARRIAGE%%")' $CONFIG_PATH)

# Prepare config file
sed -i "s/%%INTERVAL%%/$INTERVAL/g" /bluetooth_le_companion.config
sed -i "s/%%GRACE_PERIOD%%/$GRACE_PERIOD/g" /bluetooth_le_companion.config
sed -i "s/%%HOME_ASSISTANT_PORT%%/$HOME_ASSISTANT_PORT/g" /bluetooth_le_companion.config
sed -i "s/%%HOME_ASSISTANT_PASSWORD%%/$HOME_ASSISTANT_PASSWORD/g" /bluetooth_le_companion.config

sed -i "s/%%DEVICES%%/$HOME_ASSISTANT_DEVICES/g" /bluetooth_le_companion.config
sed -i "s/%%CARRIAGE%%/\n/g" /bluetooth_le_companion.config

echo "[INFO] Starting bluetooth le companion"
exec home_assistant-ble /bluetooth_le_companion.config < /dev/null