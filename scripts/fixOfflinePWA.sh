#! /bin/sh
cp scripts/pwaOffline.patch .
sed -e "s/HREFREPLACE/$(echo $HREFREPLACE)\//g" pwaOffline.patch > fix.patch
mv build/web/flutter_service_worker.js .
patch flutter_service_worker.js < fix.patch
mv flutter_service_worker.js build/web/
