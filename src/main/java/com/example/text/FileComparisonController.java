package com.example.text;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import difflib.*;
import java.util.ArrayList;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class FileComparisonController {

    @GetMapping("/")
    public String showUploadForm() {
        return "upload.jsp";
    }

    @PostMapping("/compare")
    public ModelAndView compareFiles(@RequestParam("file1") MultipartFile file1,
                                     @RequestParam("file2") MultipartFile file2) {
        ModelAndView modelAndView = new ModelAndView("comparison.jsp");

        if (file1.isEmpty() || file2.isEmpty()) {
            modelAndView.addObject("error", "Please select both files to compare. May be one of the files selected is empty.");
            return modelAndView;
        }

        try {
            String file1Content = inputStreamToString(file1.getInputStream()).replaceAll("\\s+", "");
            String file2Content = inputStreamToString(file2.getInputStream()).replaceAll("\\s+", "");

            boolean areEqual = file1Content.equals(file2Content);
            modelAndView.addObject("areEqual", areEqual);

            if (!areEqual) {
                List<String> file1Lines = IOUtils.readLines(file1.getInputStream(), StandardCharsets.UTF_8).stream()
                        .filter(line -> !line.trim().isEmpty())
                        .collect(Collectors.toList());
                List<String> file2Lines = IOUtils.readLines(file2.getInputStream(), StandardCharsets.UTF_8).stream()
                        .filter(line -> !line.trim().isEmpty())
                        .collect(Collectors.toList());
                if(file1Lines.size()<file2Lines.size()) {
                	List<String> temp = new ArrayList<String>(file1Lines);
                	file1Lines = new ArrayList<>(file2Lines);
                	file2Lines = new ArrayList<>(temp);

                 }
                Patch<String> patch = DiffUtils.diff(file1Lines, file2Lines);
                List<Delta<String>> deltas = patch.getDeltas();

                StringBuilder differences = new StringBuilder();
                for (Delta<String> delta : deltas) {
                	if (!delta.getOriginal().getLines().isEmpty()) {
                    differences.append("Line: ").append(delta.getOriginal().getPosition() + 1)
                            .append(" - ").append(delta.getOriginal().getLines().get(0)).append("\n");
                	}
                }
                

                modelAndView.addObject("differences", differences.toString());
                System.out.println(file1Lines);
                System.out.println(deltas);
            }
        } catch (Exception e) {
            modelAndView.addObject("error", "An error occurred while comparing files: " + e.getMessage());
        }

        return modelAndView;
    }



    private String inputStreamToString(InputStream inputStream) throws IOException {
        return IOUtils.toString(inputStream, StandardCharsets.UTF_8);
    }
}
