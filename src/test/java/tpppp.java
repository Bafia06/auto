import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.Assert;
import org.testng.annotations.AfterTest;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

public class tpppp {
    WebDriver driver;
    @BeforeTest
    public void before(){
        System.setProperty("webdriver.chrome.driver","src\\chromedriver\\chromedriver.exe");
        driver = new ChromeDriver();
        driver.get("https://practicetestautomation.com/");
        driver.manage().window().maximize();
    }
    @Test
    public void Test1(){
        var title = driver.getTitle();
        System.out.println(title);
        Assert.assertEquals(title,"Practice Test Automation | Learn Selenium WebDriver");
    }

    @Test
    public void Test2(){
        driver.findElement(By.xpath("//a[@href='https://practicetestautomation.com/practice/']")).click();
        driver.findElement(By.xpath("//a[@href='https://practicetestautomation.com/practice-test-login/']")).click();
        String username = "student";
        String password = System.getProperty("password");
        driver.findElement(By.xpath("//input[@id='username']")).sendKeys(username);
        driver.findElement(By.xpath("//input[@id='password']")).sendKeys(password);
        driver.findElement(By.xpath("//button[@id='submit']")).click();

        WebElement check = driver.findElement(By.xpath("//h1[contains(@class, 'post-title')]"));

        String text = check.getText();
        Assert.assertEquals(text,"Logged In Successfully");

    }
    @AfterTest
    public void closeSession(){
        //driver.quit();
    }
}
