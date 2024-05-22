import io.appium.java_client.android.AndroidDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.testng.annotations.AfterTest;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;


import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;

public class appiumTest {
    WebDriver driver;
    @BeforeTest
    public void init() throws MalformedURLException {
        File app= new File("C:\\Users\\rouqa\\Desktop\\bitbar-sample-app.apk");
        DesiredCapabilities capabilities = new DesiredCapabilities();
        capabilities.setCapability("platformName", "Android");
        capabilities.setCapability("automationName", "UiAutomator2");
        capabilities.setCapability("deviceName", "device");
        capabilities.setCapability("app", app.getAbsolutePath());
        capabilities.setCapability("appActivity", "com.bitbar.testdroid.BitbarSampleApplicationActivity");
        capabilities.setCapability("appPackage", "com.bitbar.testdroid");
        driver = new AndroidDriver(new URL("http://127.0.0.1:4723/"), capabilities);

    }

    @Test
    public void appiumTest(){
        //driver.findElement(By.xpath("//android.widget.TextView[@text='Sign up']")).click();
        driver.findElement(By.xpath("//android.widget.RadioButton[@resource-id=\"com.bitbar.testdroid:id/radio2\"]")).click();
    }

    @AfterTest
    public void quit(){
        driver.quit();
    }


}
