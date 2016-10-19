#!/bin/bash

declare -A PIN_MAP
PIN_MAP=([7]=4 [11]=17 [12]=18 [13]=27 [15]=22 [16]=23 [18]=24 [22]=25 
[29]=5 [31]=6 [32]=12 [33]=13 [35]=19 [36]=16 [37]=26 [38]=20 [40]=21)

function gpio(){

    local action=$1
    local pin=${PIN_MAP[$2]}
    local value=$3
    local gpio_path=/sys/class/gpio
    local gpio_pin=$gpio_path/gpio$pin

    case $action in
        mode)
            echo $pin > $gpio_path/export
            echo $value > $gpio_pin/direction
        ;;
        write)
            echo $value > $gpio_pin/value
        ;;
        read)
            cat $gpio_pin/value
        ;;
        delete)
            echo $pin > $gpio_path/unexport
        ;;
        print)
            echo "Raspberry Pi 3, GPIO pin numbering"
            echo "GPIO pins MAX current = 15mA"
            echo "3.3V pins MAX current = 50mA"
            echo "3.3V PWR  (1)  *  * (2)  5V PWR"
            echo "I2C1 SDA  (3)  *  * (4)  5V PWR"
            echo "I2C1 SCL  (5)  *  * (6)  GND"
            echo "GPIO 4    (7)  *  * (8)  UARTO TX"
            echo "GND       (9)  *  * (10) UARTO RX"
            echo "GPIO 17   (11) *  * (12) GPIO 18"
            echo "GPIO 27   (13) *  * (14) GND"
            echo "GPIO 22   (15) *  * (16) GPIO 23"
            echo "3.3V PWR  (17) *  * (18) GPIO 24"
            echo "SPIO MOSI (19) *  * (20) GND"
            echo "SPIO MISO (21) *  * (22) GPIO 25"
            echo "SPIO SCLK (23) *  * (24) SPIO CS0"
            echo "GND       (25) *  * (26) SPIO CS1"
            echo "Reserved  (27) *  * (28) Reserved"
            echo "GPIO 5    (29) *  * (30) GND"
            echo "GPIO 6    (31) *  * (32) GPIO 12"
            echo "GPIO 13   (33) *  * (34) GND"
            echo "GPIO 19   (35) *  * (36) GPIO 16"
            echo "GPIO 26   (37) *  * (38) GPIO 20"
            echo "GND       (39) *  * (40) GPIO 21"
        ;;
        *)
            echo "Control the GPIO pins of the Raspberry Pi"
            echo "Usage: $0 mode [pin] [in|out]"
            echo "       $0 write [pin] [0|1]"
            echo "       $0 read [pin]"
            echo "       $0 delete [pin]"
            echo "       $0 print"
        ;;
    esac
}
if [ "$BASH_SOURCE" == "$0" ]; then
    gpio $@
fi
