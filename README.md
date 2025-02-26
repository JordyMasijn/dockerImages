# dockerImages

To update/bump image, simply push the corresponding tag.
For example:

```bash
git tag alpine-awscli/v1.0.2
git push origin alpine-awscli/v1.0.2
```

this will result in a build for the ***alpine-awscli*** image and set as tag v1.0.2

Please keep in mind that the name of the image should match with the foldername inside of the containers folder.
Similarly, this name is also passed in the workflow files for it as input.

ble
