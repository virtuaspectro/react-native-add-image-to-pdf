# react-native-add-image-to-pdf

Add an image to a PDF file and save it again on file system (Android or iOS)

## Installation

```sh
npm install react-native-add-image-to-pdf
```

## Usage

```js
import RNAIPDF from 'react-native-add-image-to-pdf';

 const path = await RNAIPDF.loadImageToPDF(
        'path/to/pdf-document.pdf', //document PATH on filesystem
        'path/to/image.png', // image PATH on filesystem
        100, // Left boundary relative to document first page
        100, // Top boundary relative to document first page
        200, // Image width
        400 // Image height
      )

```
