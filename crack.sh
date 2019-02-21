mkdir -p /usr/local/tempJar
cp /usr/share/elasticsearch/modules/x-pack-core/x-pack-core-6.6.0.jar tempJar/
cd /usr/local/tempJar

jar -xf x-pack-core-6.6.0.jar
y | mv org/elasticsearch/license/LicenseVerifier.class org/elasticsearch/license/LicenseVerifier.class.bak
cp ../LicenseVerifier.class org/elasticsearch/license/
y | mv org/elasticsearch/xpack/core/XPackBuild.class org/elasticsearch/xpack/core/XPackBuild.class.bak
cp ../XPackBuild.class org/elasticsearch/xpack/core/
rm x-pack-core-6.6.0.jar
jar -cvf x-pack-core-6.6.0.jar *

cp y | /usr/share/elasticsearch/modules/x-pack-core/x-pack-core-6.6.0.jar /usr/share/elasticsearch/modules/x-pack-core/x-pack-core-6.6.0.jar.bak
cp x-pack-core-6.6.0.jar /usr/share/elasticsearch/modules/x-pack-core/