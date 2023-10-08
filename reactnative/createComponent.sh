#!/bin/bash

# Select component name
read -p 'Component a name: ' componentName
if [ -z "$componentName" ]
then
  echo Empty component name is not allowed.
  exit 1
fi

# Select output directory, configure according to project needs
outputDir="./src/components/$componentName"
read -p "Component directory (a=components b=common c=containers, or custom path): " userChosenDir
if [ $userChosenDir == "a" ] 
then
  outputDir="./src/components/$componentName"
elif [ $userChosenDir == "b" ] 
then
  outputDir="./src/components/common/$componentName"
elif [ $userChosenDir == "c" ] 
then
  outputDir="./src/containers/$componentName"
elif [ ! -z $userChosenDir ] 
then
  outputDir="$userChosenDir/$componentName"
else
  echo "Invalid directory. Exiting"
  exit 1
fi

echo Using path $outputDir
echo ""

# Make output directory
mkdir -p $outputDir

# Create component fille
componentFilePath="$outputDir/$componentName.tsx"
echo "import React from 'react'
import {"$componentName"Wrapper} from './$componentName.styles.ts'

interface "$componentName"Props {}

export default function $componentName({}: "$componentName"Props) {
  return (
    <"$componentName"Wrapper>
    </"$componentName"Wrapper>
  )
}
" > $componentFilePath
echo "Created: $componentFilePath"

# Create styles file
stylesFilePath="$outputDir/$componentName.styles.ts"
echo "import styled from 'styled-components'
import { View } from 'react-native'

export const "$componentName"Wrapper = styled(View)\`\`
" > $stylesFilePath
echo "Created: $stylesFilePath"

exit 0
