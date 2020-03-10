package bit.team.eepp.Utils;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;

import net.coobird.thumbnailator.Thumbnails;

public class UploadFileUtils
{
    static final int THUMB_WIDTH = 300;
    static final int THUMB_HEIGHT = 300;
    
    public static String fileUpload(final String uploadPath, final String fileName, final byte[] fileData, final String ymdPath) throws Exception {
        final UUID uid = UUID.randomUUID();
        final String newFileName = uid + "_" + fileName;
        final String imgPath = String.valueOf(uploadPath) + ymdPath;
        final File target = new File(imgPath, newFileName);
        FileCopyUtils.copy(fileData, target);
        final String thumbFileName = "s_" + newFileName;
        final File image = new File(String.valueOf(imgPath) + File.separator + newFileName);
        final File thumbnail = new File(String.valueOf(imgPath) + File.separator + "s" + File.separator + thumbFileName);
        if (image.exists()) {
            thumbnail.getParentFile().mkdirs();
            Thumbnails.of(new File[] { image }).size(300, 300).toFile(thumbnail);
        }
        return newFileName;
    }
    
    public static String calcPath(final String uploadPath) {
        final Calendar cal = Calendar.getInstance();
        final String yearPath = String.valueOf(File.separator) + cal.get(1);
        final String monthPath = String.valueOf(yearPath) + File.separator + new DecimalFormat("00").format(cal.get(2) + 1);
        final String datePath = String.valueOf(monthPath) + File.separator + new DecimalFormat("00").format(cal.get(5));
        makeDir(uploadPath, yearPath, monthPath, datePath);
        makeDir(uploadPath, yearPath, monthPath, String.valueOf(datePath) + "\\s");
        return datePath;
    }
    
    private static void makeDir(final String uploadPath, final String... paths) {
        if (new File(paths[paths.length - 1]).exists()) {
            return;
        }
        for (final String path : paths) {
            final File dirPath = new File(String.valueOf(uploadPath) + path);
            if (!dirPath.exists()) {
                dirPath.mkdir();
            }
        }
    }
}