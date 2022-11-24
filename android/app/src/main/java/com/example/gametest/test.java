package com.example.gametest;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;

import com.awardluxury.ludothegame.UnityPlayerActivity;

public class test extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_test);
        Intent i=new Intent(test.this, UnityPlayerActivity.class);

        startActivity(i);

    }
}