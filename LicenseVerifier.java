package org.elasticsearch.license; 
import java.nio.*; import java.util.*; 
import java.security.*; 
import org.elasticsearch.common.xcontent.*; 
import org.apache.lucene.util.*; 
import org.elasticsearch.common.io.*; 
import java.io.*; 
 
public class LicenseVerifier { 
	public LicenseVerifier() {}
	
    public static boolean verifyLicense(License license, byte[] encryptedPublicKeyData) {
        return true; 
    } 
    
    public static boolean verifyLicense(License license)     { 
        return true; 
    } 
}