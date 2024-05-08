import io.appium.java_client.AppiumDriver;
import io.appium.java_client.android.AndroidDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.testng.annotations.AfterTest;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;


import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;

public class appiumTest {
    WebDriver driver;
    @BeforeTest
    public void init() throws MalformedURLException {
        File app= new File("C:\\tools\\jenkins-agent\\Dropbox_374.2.4_apkcombo.com.apk");
        DesiredCapabilities capabilities = new DesiredCapabilities();
        capabilities.setCapability("platformName", "Android");
        capabilities.setCapability("automationName", "UiAutomator2");
        capabilities.setCapability("deviceName", "device");
        capabilities.setCapability("app", app.getAbsolutePath());
        capabilities.setCapability("appActivity", "com.dropbox.dbapp.auth.login.DbappLoginActivity");
        capabilities.setCapability("appPackage", "com.dropbox.android");
        driver = new AndroidDriver(new URL("http://192.168.100.148:4723/"), capabilities);

    }

    @Test
    public void appiumTest(){
        //driver.findElement(By.xpath("//android.widget.TextView[@text='Sign up']")).click();
        driver.findElement(By.xpath("//android.widget.Button")).click();
    }

    @AfterTest
    public void quit(){
        driver.quit();
    }


}
