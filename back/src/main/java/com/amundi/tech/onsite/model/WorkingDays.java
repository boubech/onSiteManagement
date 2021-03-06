package com.amundi.tech.onsite.model;

import com.amundi.tech.onsite.db.model.WorkingDay;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class WorkingDays {

    private String user;
    private long site;
    private LocalDate startDate;
    private List<WorkingDay> workingDays;
}
