
#!/bin/bash

score=0
echo "Running autograder..."

# Journal files check
files=(
lab_journal/01_hardware_vs_software.md
lab_journal/02_computer_disassembly.md
lab_journal/03_component_investigation.md
lab_journal/04_raspberry_pi_identification.md
lab_journal/05_reflection.md
)

count=0
for f in "${files[@]}"
do
  if [ -f "$f" ]; then
    count=$((count+1))
  fi
done

if [ $count -eq 5 ]; then
  echo "Journal files present: +10"
  score=$((score+10))
fi

# Computer images
[ -f images/system/computer-before.jpg ] && score=$((score+5))
[ -f images/system/computer-opened.jpg ] && score=$((score+5))

# Component images
components=(cpu.jpg ram.jpg storage.jpg motherboard.jpg power-supply.jpg cooling.jpg)
for c in "${components[@]}"
do
  if [ -f "images/components/$c" ]; then
    score=$((score+2))
  fi
done

# Raspberry Pi images
[ -f images/raspberry-pi/pi-board.jpg ] && score=$((score+5))
[ -f images/raspberry-pi/labelled-pi-board.jpg ] && score=$((score+5))

# Word counts
hw_words=$(wc -w < lab_journal/01_hardware_vs_software.md)
[ "$hw_words" -ge 150 ] && score=$((score+15))

pi_words=$(wc -w < lab_journal/04_raspberry_pi_identification.md)
[ "$pi_words" -ge 100 ] && score=$((score+10))

ref_words=$(wc -w < lab_journal/05_reflection.md)
[ "$ref_words" -ge 200 ] && score=$((score+15))

echo "-----------------------------"
echo "AUTOGRADE SCORE: $score / 100"
echo "-----------------------------"
