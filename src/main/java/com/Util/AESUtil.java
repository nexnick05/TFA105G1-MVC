package com.Util;

import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

public class AESUtil {
    /**
     * 將傳入的明文轉換為密文
     * @param str
     * @param pwd
     * @return
     */
    public String encode(String str,String pwd) {
        byte[] result = null;
        try {
            KeyGenerator kgen = KeyGenerator.getInstance("AES");
            SecureRandom random = SecureRandom.getInstance("SHA1PRNG");
            random.setSeed(pwd.getBytes());
            kgen.init(128, random);
            SecretKey secretKey = kgen.generateKey();
            byte[] enCodeFormat = secretKey.getEncoded();
            SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");

            // 建立密碼器
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, key);
            byte[] byteContent = str.getBytes();
            result = cipher.doFinal(byteContent);

        } catch (Exception e) {
            return null;
        }

        return parseByte2HexStr(result);
    }

    /**
     * 將傳入的密文轉換為明文
     * @param str
     * @param pwd
     * @return
     */
    public String decode(String str,String pwd) {
        byte[] result = null;
        byte[] content = parseHexStr2Byte(str);
        try {
            KeyGenerator kgen = KeyGenerator.getInstance("AES");
            SecureRandom random = SecureRandom.getInstance("SHA1PRNG");
            random.setSeed(pwd.getBytes());
            kgen.init(128, random);
            SecretKey secretKey = kgen.generateKey();
            byte[] enCodeFormat = secretKey.getEncoded();
            SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");

            // 建立密碼器
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            cipher.init(Cipher.DECRYPT_MODE, key);
            result = cipher.doFinal(content);

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        return new String(result);
    }

    /**
     * 將二進位制轉換成十六進位制
     *
     * @param buf
     * @return
     */
    private String parseByte2HexStr(byte buf[]) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < buf.length; i++) {
            String hex = Integer.toHexString(buf[i] & 0xFF);
            if (hex.length() == 1) {
                hex = '0' + hex;
            }
            sb.append(hex.toUpperCase());
        }
        return sb.toString();
    }

    /**
     * 將十六進位制轉換為二進位制
     *
     * @param hexStr
     * @return
     */
    private byte[] parseHexStr2Byte(String hexStr) {
        if (hexStr.length() < 1) {
            return null;
        }
        byte[] result = new byte[hexStr.length() / 2];
        for (int i = 0; i < hexStr.length() / 2; i++) {
            int high = Integer.parseInt(hexStr.substring(i * 2, i * 2 + 1), 16);
            int low = Integer.parseInt(hexStr.substring(i * 2 + 1, i * 2 + 2), 16);
            result[i] = (byte) (high * 16 + low);
        }
        return result;
    }
    
    public static void main(String[] args) {
    	AESUtil aes = new AESUtil();
        String content = "測試加密";
        // AES的金鑰長度最好是16位(不是必須)
        String pwd = "dfashfkjsdfhksdlf";
        
//        加密前：測試加密
//        加密後：3D9CE75197DAB6F6B9429E6A11E73288
//        解密後：測試加密


        // 加密
        System.out.println("加密前：" + content);
      String encodeResultStr = aes.encode(content,pwd);
      System.out.println("加密後：" + encodeResultStr);
      // 解密
      String decodeResultStr = aes.decode(encodeResultStr,pwd);
      System.out.println("解密後：" + decodeResultStr);
    }

}