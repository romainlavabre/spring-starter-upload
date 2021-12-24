package com.replace.replace.api.upload.move;

import com.replace.replace.api.request.UploadedFile;

/**
 * @author Romain Lavabre <romainlavabre98@gmail.com>
 */
public interface MoveRule {

    /**
     * Set path in uploaded file
     *
     * @param uploadedFile
     */
    void setDestination( UploadedFile uploadedFile );


    /**
     * Upload your file where tou want (path is ready)
     *
     * @param uploadedFile
     * @return TRUE if file is uploaded
     */
    boolean move( UploadedFile uploadedFile );
}