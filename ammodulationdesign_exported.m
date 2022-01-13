classdef ammodulationdesign_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure       matlab.ui.Figure
        GridLayout     matlab.ui.container.GridLayout
        LeftPanel      matlab.ui.container.Panel
        Button         matlab.ui.control.Button
        ASlider        matlab.ui.control.Slider
        ASliderLabel   matlab.ui.control.Label
        fcSlider       matlab.ui.control.Slider
        fcSliderLabel  matlab.ui.control.Label
        fmSlider       matlab.ui.control.Slider
        fmSliderLabel  matlab.ui.control.Label
        RightPanel     matlab.ui.container.Panel
        UIAxes3        matlab.ui.control.UIAxes
        UIAxes2        matlab.ui.control.UIAxes
        UIAxes         matlab.ui.control.UIAxes
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Callback function
        function fmSliderValueChanging(app, event)
            fm = app.fmSlider.Value;
            
            
        end

        % Callback function
        function UIAxesButtonDown(app, event)
             
           
        end

        % Callback function
        function fcSliderValueChanging(app, event)
            fc = app.fcSlider.Value;
            
            
            
        end

        % Callback function
        function ASliderValueChanging(app, event)
            A = app.ASlider.Value;
            
                
        end

        % Callback function: ASlider, Button, UIAxes, UIAxes2, UIAxes3, 
        % fcSlider, fmSlider
        function ButtonPushed(app, event)
            
            fm = app.fmSlider.Value;
            fc = app.fcSlider.Value;
            A = app.ASlider.Value;
            
            
            Ta=1/fm; 
            t=0:Ta/999:60*Ta;
            
            
            ym=cos(2*pi*fm*t);
            yc=1+A*cos(2*pi*fc*t);
            y=cos(2*pi*fm*t).*(1+(A*cos(2*pi*fc*t)));

            plot(app.UIAxes,t,ym);
            plot(app.UIAxes2,t,yc);
            plot(app.UIAxes3,t,y);
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, event)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 2x1 grid
                app.GridLayout.RowHeight = {480, 480};
                app.GridLayout.ColumnWidth = {'1x'};
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 1;
            else
                % Change to a 1x2 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {220, '1x'};
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 2;
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {220, '1x'};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create fmSliderLabel
            app.fmSliderLabel = uilabel(app.LeftPanel);
            app.fmSliderLabel.HorizontalAlignment = 'center';
            app.fmSliderLabel.FontName = 'Calibri Light';
            app.fmSliderLabel.FontSize = 20;
            app.fmSliderLabel.FontWeight = 'bold';
            app.fmSliderLabel.FontAngle = 'italic';
            app.fmSliderLabel.Position = [12 320 27 27];
            app.fmSliderLabel.Text = 'fm';

            % Create fmSlider
            app.fmSlider = uislider(app.LeftPanel);
            app.fmSlider.Limits = [0 250];
            app.fmSlider.ValueChangingFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.fmSlider.Position = [58 344 150 3];
            app.fmSlider.Value = 1;

            % Create fcSliderLabel
            app.fcSliderLabel = uilabel(app.LeftPanel);
            app.fcSliderLabel.HorizontalAlignment = 'center';
            app.fcSliderLabel.FontName = 'Calibri Light';
            app.fcSliderLabel.FontSize = 20;
            app.fcSliderLabel.FontWeight = 'bold';
            app.fcSliderLabel.FontAngle = 'italic';
            app.fcSliderLabel.Position = [3 251 42 27];
            app.fcSliderLabel.Text = 'fc';

            % Create fcSlider
            app.fcSlider = uislider(app.LeftPanel);
            app.fcSlider.Limits = [1 100];
            app.fcSlider.ValueChangingFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.fcSlider.Position = [59 277 150 3];
            app.fcSlider.Value = 1;

            % Create ASliderLabel
            app.ASliderLabel = uilabel(app.LeftPanel);
            app.ASliderLabel.HorizontalAlignment = 'center';
            app.ASliderLabel.FontName = 'Calibri Light';
            app.ASliderLabel.FontSize = 20;
            app.ASliderLabel.FontWeight = 'bold';
            app.ASliderLabel.FontAngle = 'italic';
            app.ASliderLabel.Position = [1 187 42 27];
            app.ASliderLabel.Text = 'A';

            % Create ASlider
            app.ASlider = uislider(app.LeftPanel);
            app.ASlider.Limits = [0 1];
            app.ASlider.ValueChangingFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.ASlider.Position = [58 213 150 3];

            % Create Button
            app.Button = uibutton(app.LeftPanel, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.Button.Position = [66 99 100 22];

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 2;

            % Create UIAxes
            app.UIAxes = uiaxes(app.RightPanel);
            title(app.UIAxes, {'bilgi sinyali'; ''})
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.XColor = [0 0 0];
            app.UIAxes.XTick = [0 0.2 0.4 0.6 0.8 1];
            app.UIAxes.XTickLabel = {'0'; '0.2'; '0.4'; '0.6'; '0.8'; '1'};
            app.UIAxes.YColor = [0 0 0];
            app.UIAxes.YTickLabel = {'0'; '0.5'; '1'};
            app.UIAxes.ZColor = [0 0 0];
            app.UIAxes.ColorOrder = [0 0.4471 0.7412;0.9294 0.6941 0.1255;0.4941 0.1843 0.5569;0.4667 0.6745 0.1882;0.302 0.7451 0.9333;0.6353 0.0784 0.1843];
            app.UIAxes.ButtonDownFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.UIAxes.Position = [1 320 413 130];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.RightPanel);
            title(app.UIAxes2, {'taşıyıcı sinyal'; ''})
            xlabel(app.UIAxes2, 'X')
            ylabel(app.UIAxes2, 'Y')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.XTick = [0 0.2 0.4 0.6 0.8 1];
            app.UIAxes2.XTickLabel = {'0'; '0.2'; '0.4'; '0.6'; '0.8'; '1'};
            app.UIAxes2.ButtonDownFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.UIAxes2.Position = [1 176 413 129];

            % Create UIAxes3
            app.UIAxes3 = uiaxes(app.RightPanel);
            title(app.UIAxes3, 'modüleli sinyal')
            xlabel(app.UIAxes3, 'X')
            ylabel(app.UIAxes3, 'Y')
            zlabel(app.UIAxes3, 'Z')
            app.UIAxes3.XTick = [0 0.2 0.4 0.6 0.8 1];
            app.UIAxes3.ButtonDownFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.UIAxes3.Position = [1 31 413 129];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = ammodulationdesign_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end