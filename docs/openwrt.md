# OpenWrt

## Copy development files from another package

```
cd $(STAGING_DIR)/usr/include/foo && find config -name '*.xml' -exec $(CP) --parents {} $(1)/etc/bar \;
```
