#!/bin/bash

# Select component name
read -p 'Component a name: ' componentName
if [ -z "$componentName" ]
then
  echo Empty component name is not allowed.
  exit 1
fi

# Select output directory
outputDir="./src/components/$componentName"
read -p "Component directory: (default: "./src/components/$componentName"): " userChosenDir
if [ -z "$userChosenDir" ]
then
  echo Using path $outputDir
else 
  outputDir="$userChosenDir/$componentName"
  echo Using path "$outputDir"
fi
echo ""

# Make output directory
mkdir -p $outputDir

# Create component fille
componentFilePath="$outputDir/$componentName.tsx"
echo "import React from 'react'
import { "$componentName"Container } from './$componentName.styles.ts'

export default function $componentName() {
  return (
    <"$componentName"Container>
    </"$componentName"Container>
  )
}
" > $componentFilePath
echo "Created: $componentFilePath"

# Create styles file
stylesFilePath="$outputDir/$componentName.styles.ts"
echo "import styled from 'styled-components'
import { View } from 'react-native'

export const "$componentName"Container = styled(View)\`\`
" > $stylesFilePath
echo "Created: $stylesFilePath"

exit 0
